import React, { useState } from "react";
import { Lock, User } from "lucide-react";
import { useNavigate } from "react-router-dom"; // ✅ Import navigation hook

const Login = () => {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const navigate = useNavigate(); // ✅ Initialize navigate

  const handleSubmit = (e) => {
    e.preventDefault();

    // ✅ Simple login validation
    if (username === "admin" && password === "admin123") {
      setError("");
      navigate("/home"); // ✅ Redirect to home.jsx
    } else {
      setError("Invalid username or password");
    }
  };

  return (
    <div
      className="d-flex justify-content-center align-items-center bg-dark text-light"
      style={{
        height: "100vh",
        background: "linear-gradient(135deg, #1e1b4b 0%, #312e81 100%)",
      }}
    >
      <div
        className="card p-5 shadow-lg text-center"
        style={{
          width: "100%",
          maxWidth: "400px",
          backgroundColor: "rgba(255,255,255,0.05)",
          border: "1px solid rgba(255,255,255,0.1)",
          borderRadius: "20px",
        }}
      >
        <div className="mb-4">
          <div
            className="d-inline-flex justify-content-center align-items-center mb-3 rounded-circle"
            style={{
              width: "70px",
              height: "70px",
              background: "linear-gradient(135deg, #6366f1 0%, #a855f7 100%)",
            }}
          >
            <Lock size={32} />
          </div>
          <h2 className="fw-bold text-white">Admin Login</h2>
          <p className="text-secondary small">
            Enter your credentials to access the dashboard
          </p>
        </div>

        <form onSubmit={handleSubmit}>
          {/* Username */}
          <div className="mb-3 text-start">
            <label className="form-label small text-light fw-semibold">
              Username
            </label>
            <div className="input-group">
              <span className="input-group-text bg-transparent border-secondary text-light">
                <User size={18} />
              </span>
              <input
                type="text"
                className="form-control bg-transparent text-light border-secondary"
                placeholder="Enter username"
                value={username}
                onChange={(e) => setUsername(e.target.value)}
                required
              />
            </div>
          </div>

          {/* Password */}
          <div className="mb-3 text-start">
            <label className="form-label small text-light fw-semibold">
              Password
            </label>
            <div className="input-group">
              <span className="input-group-text bg-transparent border-secondary text-light">
                <Lock size={18} />
              </span>
              <input
                type="password"
                className="form-control bg-transparent text-light border-secondary"
                placeholder="Enter password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                required
              />
            </div>
          </div>

          {/* Error Message */}
          {error && (
            <div className="alert alert-danger py-2 small" role="alert">
              {error}
            </div>
          )}

          {/* Submit Button */}
          <button
            type="submit"
            className="btn btn-primary w-100 fw-semibold mt-3"
            style={{
              background: "linear-gradient(135deg, #6366f1 0%, #a855f7 100%)",
              border: "none",
            }}
          >
            Login
          </button>
        </form>
      </div>
    </div>
  );
};

export default Login;
