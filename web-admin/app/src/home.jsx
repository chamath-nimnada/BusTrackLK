import React, { useState } from "react";

import {
  Users,
  Car,
  Calendar,
  CreditCard,
  MessageSquare,
} from "lucide-react";

// Import main tabs
import ManageAdmin from "./Tabs/ManageAdmin";
import ManageDrivers from "./Tabs/ManageDrivers";
import ManageSchedule from "./Tabs/ManageSchedule";
import ViewPayment from "./Tabs/ViewPayment";
import ViewEnquiries from "./Tabs/ViewEnquiries";

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

  return (
    <div className="admin-dashboard">
      <header className="dashboard-header">
        <h1>Admin Dashboard</h1>
        <p>Manage your platform efficiently</p>
      </header>

      {/* Top navigation tabs */}
      <div className="tabs-container">
        {tabs.map(({ id, label, icon: Icon }) => (
          <button
            key={id}
            className={`tab-button ${activeTab === id ? "active" : ""}`}
            onClick={() => setActiveTab(id)}
          >
            <Icon size={20} />
            {label}
          </button>
        ))}
      </div>

      {/* Main content area */}
      <div className="tab-content">{renderContent()}</div>
    </div>
  );
};

export default AdminDashboard;
