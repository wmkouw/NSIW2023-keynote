using LinearAlgebra


mutable struct Pendulum

    state       ::Vector{Float64}   # angle and change in angle (resting state = 0 rads)
    sensor      ::Float64           # noisy observation of angle
    
    mass        ::Float64           # Mass of pendulum bob (rod is assumed massless)
    length      ::Float64           # Length of pendulum rod
    friction    ::Float64           # Coulomb friction parameter
    mnoise_sd   ::Float64           # measurement noise standard deviation

    function Pendulum(init_state, mass, length, friction, mnoise_sd)
        "Constructor"
        
        init_sensor = init_state[1] + mnoise_sd*randn()

        return new(init_state, init_sensor, mass, length, friction, mnoise_sd)
    end
end

function params(sys::Pendulum)
    "Return parameters of system"
    return (sys.mass, sys.length, sys.friction)
end

function dzdt(state::Vector, u::Float64, params::Tuple)
    "Equations of motion"
    
    m, l, c = params        # Mass, length and friction
    
    return [state[2]; -c/(m*l^2)*state[2]-9.81/l*sin(state[1])+1/(m*l^2)*u]    
end

function RK4(sys::Pendulum, u::Float64; Δt::Float64=1.0)
    "4th-order Runge-Kutta discretization"
    
    K1 = dzdt(sys.state          , u, params(sys))
    K2 = dzdt(sys.state + K1*Δt/2, u, params(sys))
    K3 = dzdt(sys.state + K2*Δt/2, u, params(sys))
    K4 = dzdt(sys.state + K3*Δt  , u, params(sys))
    
    return Δt/6 * (K1 + 2K2 + 2K3 + K4)
end

function update!(sys::Pendulum, u::Float64; Δt::Float64 = 1.0)
    "Mutate system state and sensor measurement based on time step"
    
    # Update state based on discrete step forward in time
    sys.state  = sys.state + RK4(sys, u, Δt=Δt)

    # Measurement noise depends on change in angle (ie faster means less accurate)
    noise_level = max(1e-3, abs(sys.state[2])*sys.mnoise_sd)
    
    # Emit noisy observation of angle
    sys.sensor = sys.state[1] +  noise_level*randn()    
end

function control(t_on, t_off, T; B=1.0, M=2)
    "Pulse-based control"
    
    controls = zeros(T)
    for k in M:T
        
        a = (k < t_on) || (k > t_off) ? 0.0 : B
            
        controls[k] = mean([a; controls[k-1:-1:k-(M-1)]])
    end
    return controls    
end

function control(t::Float64; ω::Vector{Float64}=0.2, B::Float64=1.0)
    "Sinusoid-based control"
    return B*mean([sin(t*ω_i + 1e-3) for ω_i in ω])
end
