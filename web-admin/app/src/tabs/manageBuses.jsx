import React, { useState } from "react";
import { Calendar, Bus } from "lucide-react";

const ManageBuses = () => {
  const [registeredDate, setRegisteredDate] = useState("");
  const [busID, setBusID] = useState("");
  const [buses, setBuses] = useState([]);

  const handleSubmit = (e) => {
    e.preventDefault();

    if (!registeredDate || !busID) {
      alert("Please fill in all fields.");
      return;
    }

    const newBus = {
      id: buses.length + 1,
      registeredDate,
      busID,
    };

    setBuses([...buses, newBus]);
    setRegisteredDate("");
    setBusID("");
  };

  return (
    <div className="container text-light">
      <h3 className="fw-bold mb-4">
        <Bus size={22} className="me-2" />
        Register New Bus
      </h3>

      {/* Registration Form */}
      <form
        onSubmit={handleSubmit}
        className="p-4 rounded shadow-sm"
        style={{
          backgroundColor: "rgba(255,255,255,0.05)",
          border: "1px solid rgba(255,255,255,0.1)",
          borderRadius: "10px",
        }}
      >
        <div className="row g-3">
          {/* Registered Date */}
          <div className="col-md-6">
            <label className="form-label text-light fw-semibold">
              Registered Date
            </label>
            <div className="input-group">
              <span className="input-group-text bg-transparent border-secondary text-light">
                <Calendar size={18} />
              </span>
              <input
                type="date"
                className="form-control bg-transparent text-light border-secondary"
                value={registeredDate}
                onChange={(e) => setRegisteredDate(e.target.value)}
                required
              />
            </div>
          </div>

          {/* Bus ID */}
          <div className="col-md-6">
            <label className="form-label text-light fw-semibold">Bus ID</label>
            <div className="input-group">
              <span className="input-group-text bg-transparent border-secondary text-light">
                <Bus size={18} />
              </span>
              <input
                type="text"
                className="form-control bg-transparent text-light border-secondary"
                placeholder="Enter Bus ID"
                value={busID}
                onChange={(e) => setBusID(e.target.value)}
                required
              />
            </div>
          </div>
        </div>

        {/* Submit Button */}
        <div className="text-end mt-4">
          <button
            type="submit"
            className="btn btn-primary px-4 fw-semibold"
            style={{
              background: "linear-gradient(135deg, #6366f1 0%, #a855f7 100%)",
              border: "none",
            }}
          >
            Register Bus
          </button>
        </div>
      </form>

      {/* Registered Buses Table */}
      {buses.length > 0 && (
        <div className="mt-5">
          <h5 className="fw-bold mb-3">Registered Buses</h5>
          <table className="table table-dark table-striped table-bordered align-middle">
            <thead>
              <tr>
                <th>#</th>
                <th>Registered Date</th>
                <th>Bus ID</th>
              </tr>
            </thead>
            <tbody>
              {buses.map((bus) => (
                <tr key={bus.id}>
                  <td>{bus.id}</td>
                  <td>{bus.registeredDate}</td>
                  <td>{bus.busID}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
};

export default ManageBuses;
