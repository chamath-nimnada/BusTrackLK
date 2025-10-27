import React from 'react';
import { CreditCard } from 'lucide-react';

// Reusable StatCard Component
const StatCard = ({ label, value, color }) => (
  <div
    className="rounded-4 p-3 text-white shadow-sm"
    style={{
      background: color,
      minHeight: '100px',
    }}
  >
    <p className="fw-semibold mb-1 small">{label}</p>
    <h3 className="fw-bold mb-0">{value}</h3>
  </div>
);

// Main ViewPayment Component
const ViewPayment = () => {
  const payments = [
    { id: 'TXN001', customer: 'John Smith', amount: '$45.00', status: 'Completed', date: '2025-10-20' },
    { id: 'TXN002', customer: 'Emma Wilson', amount: '$32.50', status: 'Completed', date: '2025-10-20' },
    { id: 'TXN003', customer: 'David Lee', amount: '$28.00', status: 'Pending', date: '2025-10-19' },
  ];

  return (
    <div className="vstack gap-4">
      {/* Header */}
      <div className="d-flex align-items-center gap-3 mb-3">
        <div
          className="d-flex align-items-center justify-content-center rounded-3 text-white"
          style={{
            width: '80px',
            height: '80px',
            background: 'linear-gradient(135deg, #f97316 0%, #ef4444 100%)',
          }}
        >
          <CreditCard style={{ width: '40px', height: '40px' }} />
        </div>
        <div>
          <h2 className="h4 fw-bold text-white mb-1">Payment History</h2>
          <p className="text-light mb-0" style={{ color: '#fdba74' }}>
            View all transaction records
          </p>
        </div>
      </div>

      {/* Stats Row */}
      <div className="row g-3 mb-3">
        <div className="col-md-4">
          <StatCard label="Total Revenue" value="$12,450" color="linear-gradient(135deg, #22c55e 0%, #10b981 100%)" />
        </div>
        <div className="col-md-4">
          <StatCard label="Pending" value="$1,200" color="linear-gradient(135deg, #eab308 0%, #f97316 100%)" />
        </div>
        <div className="col-md-4">
          <StatCard label="Completed" value="248" color="linear-gradient(135deg, #3b82f6 0%, #06b6d4 100%)" />
        </div>
      </div>

      {/* Payment List */}
      <div className="vstack gap-2">
        {payments.map((payment) => (
          <div
            key={payment.id}
            className="d-flex align-items-center justify-content-between p-3 rounded-3"
            style={{
              backgroundColor: 'rgba(255,255,255,0.05)',
              transition: 'all 0.3s',
            }}
          >
            <div className="flex-fill">
              <p className="text-white fw-semibold mb-0">{payment.customer}</p>
              <p className="text-secondary small mb-0">
                {payment.id} • {payment.date}
              </p>
            </div>
            <div className="text-end me-4">
              <p className="text-white fw-bold fs-5 mb-0">{payment.amount}</p>
              <p
                className="small mb-0"
                style={{
                  color: payment.status === 'Completed' ? '#4ade80' : '#facc15',
                }}
              >
                {payment.status}
              </p>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default ViewPayment;
