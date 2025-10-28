<<<<<<< Updated upstream
import React, { useState } from "react";
=======
import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
>>>>>>> Stashed changes
import {
  Users,
  Car,
  Calendar,
  CreditCard,
  MessageSquare,
<<<<<<< Updated upstream
} from "lucide-react";
=======
  Truck,
  LogOut,
  ClipboardList, // for Bus Schedule
  UserCircle,
} from "lucide-react";
import axios from "axios"; // ✅ for API calls
>>>>>>> Stashed changes

// Import main tabs
import ManageAdmin from "./tabs/manageAdmin";
import ManageDrivers from "./tabs/manageDrivers";
import ManageSchedule from "./tabs/ManageSchedule";
import ViewPayment from "./tabs/viewPayment";
import ViewEnquiries from "./tabs/viewEnquiries";
<<<<<<< Updated upstream

const AdminDashboard = () => {
  const [activeTab, setActiveTab] = useState("manageAdmin");
=======
import ManageBuses from "./tabs/manageBuses";
import BusSchedule from "./tabs/BusSchedule"; // ✅ new tab for bookings

const AdminDashboard = () => {
  const [activeTab, setActiveTab] = useState("manageAdmin");
  const [adminUsername, setAdminUsername] = useState(""); // ✅ store Firebase username
  const navigate = useNavigate();

  // Fetch admin username from backend
  useEffect(() => {
    axios
      .get("http://localhost:8080/api/admin/username") // Spring Boot endpoint
      .then((res) => {
        setAdminUsername(res.data.username);
      })
      .catch((err) => {
        console.error("Error fetching admin username:", err);
      });
  }, []);
>>>>>>> Stashed changes

  const tabs = [
    { id: "manageAdmin", label: "Manage Admin", icon: Users },
    { id: "manageDrivers", label: "Manage Drivers", icon: Car },
    { id: "manageSchedule", label: "Manage Schedule", icon: Calendar },
<<<<<<< Updated upstream
    { id: "viewPayment", label: "View Payment", icon: CreditCard },
    { id: "viewEnquiries", label: "View Enquiries", icon: MessageSquare },
=======
    { id: "busSchedule", label: "Bus Schedule", icon: ClipboardList }, // ✅ new tab
    { id: "viewPayment", label: "View Payment", icon: CreditCard },
    { id: "viewEnquiries", label: "View Enquiries", icon: MessageSquare },
    { id: "manageBuses", label: "Buses", icon: Truck },
>>>>>>> Stashed changes
  ];

  const renderContent = () => {
    switch (activeTab) {
      case "manageAdmin":
        return <ManageAdmin />;
      case "manageDrivers":
        return <ManageDrivers />;
      case "manageSchedule":
        return <ManageSchedule />;
<<<<<<< Updated upstream
=======
      case "busSchedule":
        return <BusSchedule />; // ✅ added
>>>>>>> Stashed changes
      case "viewPayment":
        return <ViewPayment />;
      case "viewEnquiries":
        return <ViewEnquiries />;
<<<<<<< Updated upstream
=======
      case "manageBuses":
        return <ManageBuses />;
>>>>>>> Stashed changes
      default:
        return null;
    }
  };
<<<<<<< Updated upstream
{/*hiii*/}
=======

>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
        className="py-4 px-5 border-bottom border-secondary"
=======
        className="d-flex justify-content-between align-items-center py-4 px-5 border-bottom border-secondary"
>>>>>>> Stashed changes
        style={{
          background: "linear-gradient(135deg, #6366f1 0%, #a855f7 100%)",
        }}
      >
<<<<<<< Updated upstream
        <h1 className="h3 fw-bold text-white mb-0">Admin Dashboard</h1>
        <p className="text-white-50 mb-0">Manage your platform efficiently</p>
=======
        <div>
          <h1 className="h3 fw-bold text-white mb-0">Admin Dashboard</h1>
          <p className="text-white-50 mb-0">
            Welcome,{" "}
            <span className="fw-semibold text-white">
              <UserCircle size={16} className="me-1" />
              {adminUsername || "Loading..."}
            </span>
          </p>
        </div>

        {/* Logout Button */}
        <button
          className="btn btn-danger d-flex align-items-center gap-2"
          onClick={() => navigate("/")}
        >
          <LogOut size={16} />
          Logout
        </button>
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
              (e.currentTarget.style.backgroundColor =
                "rgba(255,255,255,0.1)")
=======
              (e.currentTarget.style.backgroundColor = "rgba(255,255,255,0.1)")
>>>>>>> Stashed changes
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
