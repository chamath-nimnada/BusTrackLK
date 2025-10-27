import React, { useState } from "react";
import { MessageSquare, Eye, Trash2, Reply } from "lucide-react";

const ViewEnquiries = () => {
  const [activeSubTab, setActiveSubTab] = useState("all");

  const subTabs = [
    { id: "all", label: "All Enquiries", icon: MessageSquare },
    { id: "unread", label: "Unread", icon: Eye },
    { id: "responded", label: "Responded", icon: Reply },
    { id: "deleted", label: "Deleted", icon: Trash2 },
  ];

  const enquiries = [
    {
      id: "ENQ001",
      name: "John Doe",
      email: "john@example.com",
      message: "Is the route to airport available on weekends?",
      date: "2025-10-20",
      status: "Unread",
    },
    {
      id: "ENQ002",
      name: "Sarah Smith",
      email: "sarah@example.com",
      message: "Can I change my booking schedule?",
      date: "2025-10-19",
      status: "Responded",
    },
    {
      id: "ENQ003",
      name: "Mark Wilson",
      email: "mark@example.com",
      message: "Do you provide group discounts?",
      date: "2025-10-18",
      status: "Deleted",
    },
  ];

  const filteredEnquiries = enquiries.filter((enq) => {
    if (activeSubTab === "all") return true;
    if (activeSubTab === "unread") return enq.status === "Unread";
    if (activeSubTab === "responded") return enq.status === "Responded";
    if (activeSubTab === "deleted") return enq.status === "Deleted";
    return false;
  });

  return (
    <div className="vstack gap-4">
      {/* Header */}
      <div className="d-flex align-items-center gap-3 mb-3">
        <div
          className="d-flex align-items-center justify-content-center rounded-3 text-white"
          style={{
            width: "80px",
            height: "80px",
            background: "linear-gradient(135deg, #6366f1 0%, #a855f7 100%)",
          }}
        >
          <MessageSquare style={{ width: "40px", height: "40px" }} />
        </div>
        <div>
          <h2 className="h4 fw-bold text-white mb-1">View Enquiries</h2>
          <p className="text-light mb-0" style={{ color: "#c7d2fe" }}>
            Manage customer enquiries and responses
          </p>
        </div>
      </div>

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

      {/* Enquiries List */}
      <div className="vstack gap-3">
        {filteredEnquiries.length === 0 ? (
          <p className="text-light text-center opacity-75">No enquiries found</p>
        ) : (
          filteredEnquiries.map((enq) => (
            <div
              key={enq.id}
              className="d-flex align-items-start justify-content-between p-3 rounded-3"
              style={{
                backgroundColor: "rgba(255,255,255,0.05)",
                transition: "all 0.3s",
              }}
            >
              <div className="flex-fill">
                <h5 className="text-white mb-1">{enq.name}</h5>
                <p className="text-secondary small mb-1">{enq.email}</p>
                <p className="text-light mb-2">{enq.message}</p>
                <p className="small mb-0 text-secondary">
                  {enq.id} • {enq.date}
                </p>
              </div>
              <div className="d-flex flex-column align-items-end gap-2">
                <span
                  className={`badge ${
                    enq.status === "Unread"
                      ? "bg-warning text-dark"
                      : enq.status === "Responded"
                      ? "bg-success"
                      : "bg-secondary"
                  }`}
                >
                  {enq.status}
                </span>
                <div className="d-flex gap-2">
                  <button className="btn btn-sm btn-outline-light border-0">
                    <Reply size={18} />
                  </button>
                  <button className="btn btn-sm btn-outline-light border-0">
                    <Trash2 size={18} />
                  </button>
                </div>
              </div>
            </div>
          ))
        )}
      </div>
    </div>
  );
};

export default ViewEnquiries;
