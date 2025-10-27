import React, { useState } from "react";
import { UserPlus, UserCog } from "lucide-react";
import FormInput from "../tabs/FormInput";
import FormSelect from "../tabs/FormSelect";

const ManageAdmin = () => {
  const [activeSubTab, setActiveSubTab] = useState("add");

  const subTabs = [
    { id: "add", label: "Add Admin", icon: UserPlus },
    { id: "update", label: "Update Admin", icon: UserCog },
  ];

  return (
    <div>
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

      {/* SubTab Content */}
      <div
        className="bg-white bg-opacity-10 rounded-4 p-3 shadow-lg border border-white border-opacity-10"
        style={{
          backdropFilter: "blur(10px)",
          backgroundColor: "rgba(255,255,255,0.1)",
          width: "100%",
        }}
      >
        {activeSubTab === "add" ? <AddAdminForm /> : <UpdateAdminForm />}
      </div>
    </div>
  );
};

// ---------------- Add Admin Form ----------------
const AddAdminForm = () => (
  <div className="vstack gap-4">
    <div className="d-flex align-items-center gap-3 mb-3">
      <div
        className="d-flex align-items-center justify-content-center rounded-3 text-white"
        style={{
          width: "80px",
          height: "80px",
          background: "linear-gradient(135deg, #a855f7 0%, #ec4899 100%)",
        }}
      >
        <UserPlus style={{ width: "40px", height: "40px" }} />
      </div>
      <div>
        <h2 className="h4 fw-bold text-white mb-1">Add New Admin</h2>
        <p className="text-light mb-0" style={{ color: "#d8b4fe" }}>
          Create a new administrator account
        </p>
      </div>
    </div>

    <div className="row g-3">
      <div className="col-md-6">
        <FormInput label="Full Name" placeholder="John Doe" />
      </div>
      <div className="col-md-6">
        <FormInput label="Email" placeholder="admin@example.com" type="email" />
      </div>
      <div className="col-md-6">
        <FormInput label="Username" placeholder="johndoe" />
      </div>
      <div className="col-md-6">
        <FormInput label="Password" placeholder="••••••••" type="password" />
      </div>
      <div className="col-md-6">
        <FormSelect label="Role" options={["Super Admin", "Admin", "Moderator"]} />
      </div>
      <div className="col-md-6">
        <FormInput label="Phone Number" placeholder="+1 234 567 8900" />
      </div>
    </div>

    <button
      className="btn btn-lg w-100 text-white fw-semibold mt-3 shadow border-0"
      style={{
        background: "linear-gradient(90deg, #a855f7 0%, #ec4899 100%)",
        transition: "all 0.3s",
      }}
    >
      Create Admin Account
    </button>
  </div>
);

// ---------------- Update Admin Form ----------------
const UpdateAdminForm = () => (
  <div className="vstack gap-4">
    <div className="d-flex align-items-center gap-3 mb-3">
      <div
        className="d-flex align-items-center justify-content-center rounded-3 text-white"
        style={{
          width: "80px",
          height: "80px",
          background: "linear-gradient(135deg, #a855f7 0%, #ec4899 100%)",
        }}
      >
        <UserCog style={{ width: "40px", height: "40px" }} />
      </div>
      <div>
        <h2 className="h4 fw-bold text-white mb-1">Update Admin</h2>
        <p className="text-light mb-0" style={{ color: "#d8b4fe" }}>
          Modify administrator information
        </p>
      </div>
    </div>

    <FormSelect
      label="Select Admin"
      options={["John Doe", "Jane Smith", "Mike Johnson"]}
    />
    <div className="row g-3">
      <div className="col-md-6">
        <FormInput label="Full Name" placeholder="John Doe" />
      </div>
      <div className="col-md-6">
        <FormInput label="Email" placeholder="admin@example.com" type="email" />
      </div>
      <div className="col-md-6">
        <FormSelect label="Role" options={["Super Admin", "Admin", "Moderator"]} />
      </div>
      <div className="col-md-6">
        <FormInput label="Phone Number" placeholder="+1 234 567 8900" />
      </div>
    </div>

    <button
      className="btn btn-lg w-100 text-white fw-semibold mt-3 shadow border-0"
      style={{
        background: "linear-gradient(90deg, #a855f7 0%, #ec4899 100%)",
        transition: "all 0.3s",
      }}
    >
      Update Admin
    </button>
  </div>
);

export default ManageAdmin;
