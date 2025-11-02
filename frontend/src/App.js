import React, { useState } from 'react';
import './App.css';
import ChatInterface from './components/ChatInterface';
import AdminDashboard from './components/AdminDashboard';
import { FiMessageSquare, FiBarChart2 } from 'react-icons/fi';

function App() {
  const [activeTab, setActiveTab] = useState('chat');

  return (
    <div className="App">
      <header className="app-header">
        <div className="header-content">
          <h1 className="app-title">AskEd</h1>
          <p className="app-subtitle">RAG-Based AI Chatbot for University Student Services</p>
        </div>
        <nav className="nav-tabs">
          <button
            className={`nav-tab ${activeTab === 'chat' ? 'active' : ''}`}
            onClick={() => setActiveTab('chat')}
          >
            <FiMessageSquare className="nav-icon" />
            Chat
          </button>
          <button
            className={`nav-tab ${activeTab === 'dashboard' ? 'active' : ''}`}
            onClick={() => setActiveTab('dashboard')}
          >
            <FiBarChart2 className="nav-icon" />
            Admin Dashboard
          </button>
        </nav>
      </header>
      <main className="app-main">
        {activeTab === 'chat' ? <ChatInterface /> : <AdminDashboard />}
      </main>
    </div>
  );
}

export default App;

