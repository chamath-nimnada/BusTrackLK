<<<<<<< Updated upstream
import React, { useState } from "react";
import { CheckCircle, XCircle } from "lucide-react";

const ManageDriver = () => {
  const [activeSubTab, setActiveSubTab] = useState("activate");

  const subTabs = [
    { id: "activate", label: "Activate Driver", icon: CheckCircle },
    { id: "deactivate", label: "Deactivate Driver", icon: XCircle },
  ];

  const renderContent = () => {
    switch (activeSubTab) {
      case "activate":
        return <ActivateDriverForm />;
      case "deactivate":
        return <DeactivateDriverForm />;
      default:
        return null;
    }
  };

  return (
    <div className="vstack gap-4">
      {/* Sub Tabs */}
      <div className="d-flex gap-2 mb-3">
        {subTabs.map((subTab) => {
          const Icon = subTab.icon;
          const isActive = activeSubTab === subTab.id;
          return (
            <button
              key={subTab.id}
              onClick={() => setActiveSubTab(subTab.id)}
              className={`btn d-flex align-items-center gap-2 px-4 py-2 rounded-3 border-0 ${
                isActive ? "text-white shadow" : "text-light"
              }`}
              style={{
                backgroundColor: isActive
                  ? "rgba(255,255,255,0.2)"
                  : "rgba(255,255,255,0.05)",
                transition: "all 0.3s",
              }}
              onMouseEnter={(e) =>
                (e.currentTarget.style.backgroundColor =
                  "rgba(255,255,255,0.1)")
              }
              onMouseLeave={(e) =>
                (e.currentTarget.style.backgroundColor = isActive
                  ? "rgba(255,255,255,0.2)"
                  : "rgba(255,255,255,0.05)")
              }
            >
              <Icon style={{ width: "20px", height: "20px" }} />
              <span className="fw-medium">{subTab.label}</span>
            </button>
          );
        })}
      </div>

      {/* Sub Content */}
      <div
        className="bg-white bg-opacity-10 rounded-4 p-3 shadow-lg border border-white border-opacity-10"
        style={{
          backdropFilter: "blur(10px)",
          backgroundColor: "rgba(255,255,255,0.1)",
          width: "100%",
        }}
      >
        {renderContent()}
      </div>
=======
import React, { useEffect, useState } from "react";
import axios from "axios";
import { CheckCircle } from "lucide-react";

const ManageDriver = () => {
  const [drivers, setDrivers] = useState([]);
  const [loading, setLoading] = useState(true);

  // ✅ Fetch all drivers from Firebase Firestore via Spring Boot API
  useEffect(() => {
    const fetchDrivers = async () => {
      try {
        const response = await axios.get("http://localhost:8080/api/drivers/all");
        setDrivers(response.data || []);
      } catch (error) {
        console.error("Error fetching drivers:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchDrivers();
  }, []);

  // ✅ Handle Activate/Deactivate for a driver
  const toggleStatus = async (uid, currentStatus) => {
    const newStatus = currentStatus?.trim() === "active" ? "inactive" : "active";

    try {
      // PUT request to update status in Firestore via Spring Boot
      await axios.put(
        `http://localhost:8080/api/drivers/${uid}/status?status=${newStatus}`
      );

      // Update driver status in UI immediately
      const updatedDrivers = drivers.map((driver) =>
        driver.uid === uid ? { ...driver, status: newStatus } : driver
      );
      setDrivers(updatedDrivers);

      alert(`Driver status updated to ${newStatus.toUpperCase()}`);
    } catch (error) {
      console.error("Error updating driver status:", error);
      alert("Failed to update driver status");
    }
  };

  if (loading) {
    return <p className="text-light">Loading driver details...</p>;
  }

  if (drivers.length === 0) {
    return <p className="text-light">No drivers found in Firestore.</p>;
  }

  return (
    <div className="vstack gap-4 text-white">
      {/* Header */}
      <div className="d-flex align-items-center gap-3 mb-3">
        <div
          className="d-flex align-items-center justify-content-center rounded-3 text-white"
          style={{
            width: "80px",
            height: "80px",
            background: "linear-gradient(135deg, #3b82f6 0%, #06b6d4 100%)",
          }}
        >
          <CheckCircle style={{ width: "40px", height: "40px" }} />
        </div>
        <div>
          <h2 className="h4 fw-bold mb-1">Manage Drivers</h2>
          <p className="text-light mb-0">
            View, activate, or deactivate driver accounts
          </p>
        </div>
      </div>

      {/* Display Each Driver */}
      {drivers.map((driver, index) => (
        <div
          key={driver.uid}
          className="p-4 rounded-3 shadow-sm"
          style={{
            backgroundColor: "rgba(255, 255, 255, 0.05)",
            border: "1px solid rgba(255,255,255,0.1)",
          }}
        >
          <h5 className="fw-bold mb-3 text-info">
            Driver {index + 1} Details
          </h5>
          <p>🚌 <b>Bus No:</b> {driver.busNo || "N/A"}</p>
          <p>🚏 <b>Bus Route:</b> {driver.busRoute || "N/A"}</p>
          <p>📧 <b>Email:</b> {driver.email || "N/A"}</p>
          <p>📞 <b>Phone:</b> {driver.phoneNo || "N/A"}</p>
          <p>🆔 <b>NIC:</b> {driver.nic || "N/A"}</p>
          <p>🔑 <b>UID:</b> {driver.uid || "N/A"}</p>
          <p
            style={{
              color:
                driver.status?.trim() === "active"
                  ? "#4ade80"
                  : driver.status?.trim() === "approved"
                  ? "#38bdf8"
                  : "#f87171",
            }}
          >
            ⚙️ <b>Status:</b> {driver.status || "unknown"}
          </p>

          <button
            className="btn text-white px-4 py-2 rounded-3 border-0 shadow-sm mt-2"
            style={{
              background:
                driver.status?.trim() === "active"
                  ? "linear-gradient(90deg, #ef4444 0%, #ec4899 100%)"
                  : "linear-gradient(90deg, #22c55e 0%, #10b981 100%)",
            }}
            onClick={() => toggleStatus(driver.uid, driver.status)}
          >
            {driver.status?.trim() === "active" ? "Deactivate" : "Activate"}
          </button>
        </div>
      ))}
>>>>>>> Stashed changes
    </div>
  );
};

<<<<<<< Updated upstream
const ActivateDriverForm = () => (
  <div className="vstack gap-4">
    <div className="d-flex align-items-center gap-3 mb-3">
      <div
        className="d-flex align-items-center justify-content-center rounded-3 text-white"
        style={{
          width: "80px",
          height: "80px",
          background: "linear-gradient(135deg, #3b82f6 0%, #06b6d4 100%)",
        }}
      >
        <CheckCircle style={{ width: "40px", height: "40px" }} />
      </div>
      <div>
        <h2 className="h4 fw-bold text-white mb-1">Activate Driver</h2>
        <p className="text-light mb-0" style={{ color: "#93c5fd" }}>
          Enable driver account and access
        </p>
      </div>
    </div>
    <div className="vstack gap-3">
      {["Michael Brown - ID: DR001", "Sarah Wilson - ID: DR002", "Tom Anderson - ID: DR003"].map(
        (driver, idx) => (
          <div
            key={idx}
            className="d-flex align-items-center justify-content-between p-3 rounded-3"
            style={{
              backgroundColor: "rgba(255,255,255,0.05)",
              transition: "all 0.3s",
            }}
          >
            <div className="d-flex align-items-center gap-3">
              <div
                className="rounded-circle d-flex align-items-center justify-content-center text-white fw-bold"
                style={{
                  width: "48px",
                  height: "48px",
                  background:
                    "linear-gradient(135deg, #60a5fa 0%, #22d3ee 100%)",
                }}
              >
                {driver.charAt(0)}
              </div>
              <div>
                <p className="text-white fw-semibold mb-0">{driver}</p>
                <p className="text-secondary small mb-0">Status: Inactive</p>
              </div>
            </div>
            <button
              className="btn text-white px-4 py-2 rounded-3 shadow-sm border-0"
              style={{
                background:
                  "linear-gradient(90deg, #22c55e 0%, #10b981 100%)",
                transition: "all 0.3s",
              }}
            >
              Activate
            </button>
          </div>
        )
      )}
    </div>
  </div>
);

const DeactivateDriverForm = () => (
  <div className="vstack gap-4">
    <div className="d-flex align-items-center gap-3 mb-3">
      <div
        className="d-flex align-items-center justify-content-center rounded-3 text-white"
        style={{
          width: "80px",
          height: "80px",
          background: "linear-gradient(135deg, #3b82f6 0%, #06b6d4 100%)",
        }}
      >
        <XCircle style={{ width: "40px", height: "40px" }} />
      </div>
      <div>
        <h2 className="h4 fw-bold text-white mb-1">Deactivate Driver</h2>
        <p className="text-light mb-0" style={{ color: "#93c5fd" }}>
          Disable driver account and access
        </p>
      </div>
    </div>
    <div className="vstack gap-3">
      {["Robert Davis - ID: DR004", "Emily Clark - ID: DR005", "James Moore - ID: DR006"].map(
        (driver, idx) => (
          <div
            key={idx}
            className="d-flex align-items-center justify-content-between p-3 rounded-3"
            style={{
              backgroundColor: "rgba(255,255,255,0.05)",
              transition: "all 0.3s",
            }}
          >
            <div className="d-flex align-items-center gap-3">
              <div
                className="rounded-circle d-flex align-items-center justify-content-center text-white fw-bold"
                style={{
                  width: "48px",
                  height: "48px",
                  background:
                    "linear-gradient(135deg, #60a5fa 0%, #22d3ee 100%)",
                }}
              >
                {driver.charAt(0)}
              </div>
              <div>
                <p className="text-white fw-semibold mb-0">{driver}</p>
                <p className="small mb-0" style={{ color: "#4ade80" }}>
                  Status: Active
                </p>
              </div>
            </div>
            <button
              className="btn text-white px-4 py-2 rounded-3 shadow-sm border-0"
              style={{
                background:
                  "linear-gradient(90deg, #ef4444 0%, #ec4899 100%)",
                transition: "all 0.3s",
              }}
            >
              Deactivate
            </button>
          </div>
        )
      )}
    </div>
  </div>
);

=======
>>>>>>> Stashed changes
export default ManageDriver;
