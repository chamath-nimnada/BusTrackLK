import React from "react";

const FormInput = ({ label, placeholder, type = "text" }) => (
  <div className="mb-3">
    <label
      className="form-label text-light fw-semibold small"
      style={{ color: "#d8b4fe" }}
    >
      {label}
    </label>
    <input
      type={type}
      placeholder={placeholder}
      className="form-control bg-white bg-opacity-10 border border-white border-opacity-25 rounded-3 text-white"
      style={{
        backgroundColor: "rgba(255,255,255,0.1)",
        borderColor: "rgba(255,255,255,0.2)",
      }}
    />
  </div>
);

export default FormInput;
