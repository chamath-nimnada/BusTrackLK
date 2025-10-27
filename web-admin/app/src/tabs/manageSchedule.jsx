import React, { useState } from "react";
import { Plus, Edit } from "lucide-react";
import FormInput from "../tabs/FormInput";
import FormSelect from "../tabs/FormSelect";

const ManageSchedule = () => {
  const [activeSubTab, setActiveSubTab] = useState("add");

  return (
    <div className="vstack gap-3">
      {/* Sub Tabs */}
      <div className="d-flex gap-2 mb-3">
        {[
          { id: "add", label: "Add Schedule", icon: Plus },
          { id: "update", label: "Update Schedule", icon: Edit },
        ].map((subTab) => {
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

      {/* Content Area */}
      <div
        className="bg-white bg-opacity-10 rounded-4 p-3 shadow-lg border border-white border-opacity-10"
        style={{
          backdropFilter: "blur(10px)",
          backgroundColor: "rgba(255,255,255,0.1)",
          width: "100%",
        }}
      >
        {activeSubTab === "add" ? <AddScheduleForm /> : <UpdateScheduleForm />}
      </div>
    </div>
  );
};

const AddScheduleForm = () => (
  <div className="vstack gap-4">
    <div className="d-flex align-items-center gap-3 mb-3">
      <div
        className="d-flex align-items-center justify-content-center rounded-3 text-white"
        style={{
          width: "80px",
          height: "80px",
          background: "linear-gradient(135deg, #22c55e 0%, #10b981 100%)",
        }}
      >
        <Plus style={{ width: "40px", height: "40px" }} />
      </div>
      <div>
        <h2 className="h4 fw-bold text-white mb-1">Add Schedule</h2>
        <p className="text-light mb-0" style={{ color: "#86efac" }}>
          Create a new route schedule
        </p>
      </div>
    </div>

    <div className="row g-3">
      <div className="col-md-6">
        <FormInput label="Route Name" placeholder="Route 101" />
      </div>
      <div className="col-md-6">
        <FormSelect
          label="Driver"
          options={["Michael Brown", "Sarah Wilson", "Tom Anderson"]}
        />
      </div>
      <div className="col-md-6">
        <FormInput label="Start Location" placeholder="Central Station" />
      </div>
      <div className="col-md-6">
        <FormInput label="End Location" placeholder="Airport Terminal" />
      </div>
      <div className="col-md-6">
        <FormInput label="Departure Time" type="time" />
      </div>
      <div className="col-md-6">
        <FormInput label="Arrival Time" type="time" />
      </div>
      <div className="col-md-6">
        <FormInput label="Date" type="date" />
      </div>
      <div className="col-md-6">
        <FormInput label="Fare" placeholder="$25.00" />
      </div>
    </div>

    <button
      className="btn btn-lg w-100 text-white fw-semibold mt-3 shadow border-0"
      style={{
        background: "linear-gradient(90deg, #22c55e 0%, #10b981 100%)",
        transition: "all 0.3s",
      }}
    >
      Create Schedule
    </button>
  </div>
);

const UpdateScheduleForm = () => (
  <div className="vstack gap-4">
    <div className="d-flex align-items-center gap-3 mb-3">
      <div
        className="d-flex align-items-center justify-content-center rounded-3 text-white"
        style={{
          width: "80px",
          height: "80px",
          background: "linear-gradient(135deg, #22c55e 0%, #10b981 100%)",
        }}
      >
        <Edit style={{ width: "40px", height: "40px" }} />
      </div>
      <div>
        <h2 className="h4 fw-bold text-white mb-1">Update Schedule</h2>
        <p className="text-light mb-0" style={{ color: "#86efac" }}>
          Modify existing route schedule
        </p>
      </div>
    </div>

    <FormSelect
      label="Select Schedule"
      options={["Route 101", "Route 202", "Route 303"]}
    />

    <div className="row g-3">
      <div className="col-md-6">
        <FormInput label="Route Name" placeholder="Route 101" />
      </div>
      <div className="col-md-6">
        <FormSelect
          label="Driver"
          options={["Michael Brown", "Sarah Wilson", "Tom Anderson"]}
        />
      </div>
      <div className="col-md-6">
        <FormInput label="Start Location" placeholder="Central Station" />
      </div>
      <div className="col-md-6">
        <FormInput label="End Location" placeholder="Airport Terminal" />
      </div>
      <div className="col-md-6">
        <FormInput label="Departure Time" type="time" />
      </div>
      <div className="col-md-6">
        <FormInput label="Arrival Time" type="time" />
      </div>
    </div>

    <button
      className="btn btn-lg w-100 text-white fw-semibold mt-3 shadow border-0"
      style={{
        background: "linear-gradient(90deg, #22c55e 0%, #10b981 100%)",
        transition: "all 0.3s",
      }}
    >
      Update Schedule
    </button>
  </div>
);

export default ManageSchedule;
