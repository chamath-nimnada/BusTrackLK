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
    </div>
  );
};

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

export default ManageDriver;
