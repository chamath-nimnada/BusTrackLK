import React from "react";

const FormSelect = ({ label, options }) => (
  <div className="mb-3">
    <label
      className="form-label text-light fw-semibold small"
      style={{ color: "#d8b4fe" }}
    >
      {label}
    </label>
    <select
      className="form-select bg-white bg-opacity-10 border border-white border-opacity-25 rounded-3 text-white"
      style={{
        backgroundColor: "rgba(255,255,255,0.1)",
        borderColor: "rgba(255,255,255,0.2)",
      }}
    >
      <option value="" className="bg-dark">
        Select {label}
      </option>
      {options.map((option, idx) => (
        <option key={idx} value={option} className="bg-dark">
          {option}
        </option>
      ))}
    </select>
  </div>
);

export default FormSelect;
