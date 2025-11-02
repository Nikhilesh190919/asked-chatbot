import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { FiTrendingUp, FiUsers, FiClock, FiStar, FiMessageSquare } from 'react-icons/fi';
import './AdminDashboard.css';

const API_URL = 'http://localhost:8000/api/analytics';

function AdminDashboard() {
  const [analytics, setAnalytics] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchAnalytics();
    // Refresh analytics every 30 seconds
    const interval = setInterval(fetchAnalytics, 30000);
    return () => clearInterval(interval);
  }, []);

  const fetchAnalytics = async () => {
    try {
      const response = await axios.get(API_URL);
      setAnalytics(response.data);
      setLoading(false);
    } catch (error) {
      console.error('Error fetching analytics:', error);
      setLoading(false);
    }
  };

  if (loading) {
    return (
      <div className="dashboard-container">
        <div className="loading-spinner">Loading analytics...</div>
      </div>
    );
  }

  if (!analytics) {
    return (
      <div className="dashboard-container">
        <div className="error-message">Failed to load analytics</div>
      </div>
    );
  }

  return (
    <div className="dashboard-container">
      <div className="dashboard-header">
        <h2>Analytics Dashboard</h2>
        <button className="refresh-button" onClick={fetchAnalytics}>
          Refresh
        </button>
      </div>

      <div className="stats-grid">
        <StatCard
          icon={<FiMessageSquare />}
          title="Total Queries"
          value={analytics.total_queries.toLocaleString()}
          color="#667eea"
        />
        <StatCard
          icon={<FiUsers />}
          title="Active Users"
          value={analytics.active_users.toLocaleString()}
          color="#764ba2"
        />
        <StatCard
          icon={<FiClock />}
          title="Avg Response Time"
          value={`${analytics.response_time_avg}s`}
          color="#f093fb"
        />
        <StatCard
          icon={<FiStar />}
          title="Satisfaction Score"
          value={`${analytics.satisfaction_score}/5.0`}
          color="#4facfe"
        />
      </div>

      <div className="popular-questions">
        <h3 className="section-title">
          <FiTrendingUp className="section-icon" />
          Popular Questions
        </h3>
        <div className="questions-list">
          {analytics.popular_questions.map((item, idx) => (
            <div key={idx} className="question-item">
              <div className="question-rank">#{idx + 1}</div>
              <div className="question-content">
                <div className="question-text">{item.question}</div>
                <div className="question-count">{item.count} queries</div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}

function StatCard({ icon, title, value, color }) {
  return (
    <div className="stat-card">
      <div className="stat-icon" style={{ background: `linear-gradient(135deg, ${color}20 0%, ${color}10 100%)`, borderColor: `${color}40` }}>
        {icon}
      </div>
      <div className="stat-info">
        <div className="stat-title">{title}</div>
        <div className="stat-value" style={{ color }}>{value}</div>
      </div>
    </div>
  );
}

export default AdminDashboard;

