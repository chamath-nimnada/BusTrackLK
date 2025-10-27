import React, { useState } from "react";
import {
  Users,
  Car,
  Calendar,
  CreditCard,
  MessageSquare,
} from "lucide-react";

// Import main tabs
import ManageAdmin from "./tabs/manageAdmin";
import ManageDrivers from "./tabs/manageDrivers";
import ManageSchedule from "./tabs/ManageSchedule";
import ViewPayment from "./tabs/viewPayment";
import ViewEnquiries from "./tabs/viewEnquiries";

const AdminDashboard = () => {
  const [activeTab, setActiveTab] = useState("manageAdmin");

  const tabs = [
    { id: "manageAdmin", label: "Manage Admin", icon: Users },
    { id: "manageDrivers", label: "Manage Drivers", icon: Car },
    { id: "manageSchedule", label: "Manage Schedule", icon: Calendar },
    { id: "viewPayment", label: "View Payment", icon: CreditCard },
    { id: "viewEnquiries", label: "View Enquiries", icon: MessageSquare },
  ];

  const renderContent = () => {
    switch (activeTab) {
      case "manageAdmin":
        return <ManageAdmin />;
      case "manageDrivers":
        return <ManageDrivers />;
      case "manageSchedule":
        return <ManageSchedule />;
      case "viewPayment":
        return <ViewPayment />;
      case "viewEnquiries":
        return <ViewEnquiries />;
      default:
        return null;
    }
  };
{/*hiii*/}
  return (
    <div
      className="d-flex flex-column min-vh-100 bg-dark text-light"
      style={{
        width: "100vw",
        height: "100vh",
        overflow: "hidden",
      }}
    >
      {/* Header */}
      <header
        className="py-4 px-5 border-bottom border-secondary"
        style={{
          background: "linear-gradient(135deg, #6366f1 0%, #a855f7 100%)",
        }}
      >
        <h1 className="h3 fw-bold text-white mb-0">Admin Dashboard</h1>
        <p className="text-white-50 mb-0">Manage your platform efficiently</p>
      </header>

      {/* Tabs Navigation */}
      <div
        className="d-flex justify-content-around align-items-center border-bottom border-secondary flex-wrap"
        style={{
          backgroundColor: "rgba(255,255,255,0.05)",
          padding: "0.75rem 1rem",
        }}
      >
        {tabs.map(({ id, label, icon: Icon }) => (
          <button
            key={id}
            onClick={() => setActiveTab(id)}
            className={`btn d-flex align-items-center gap-2 text-light fw-semibold border-0 px-3 py-2 rounded-3 ${
              activeTab === id ? "bg-primary text-white shadow" : ""
            }`}
            style={{
              transition: "all 0.3s ease",
              backgroundColor:
                activeTab === id ? "rgba(99,102,241,0.3)" : "transparent",
            }}
            onMouseEnter={(e) =>
              (e.currentTarget.style.backgroundColor =
                "rgba(255,255,255,0.1)")
            }
            onMouseLeave={(e) =>
              (e.currentTarget.style.backgroundColor =
                activeTab === id ? "rgba(99,102,241,0.3)" : "transparent")
            }
          >
            <Icon size={18} />
            <span>{label}</span>
          </button>
        ))}
      </div>

      {/* Main Content */}
      <div
        className="flex-grow-1 overflow-auto p-4"
        style={{
          backgroundColor: "#111827",
          minHeight: "0",
        }}
      >
        <div className="container-fluid">{renderContent()}</div>
      </div>
    </div>
  );
};

export default AdminDashboard;
