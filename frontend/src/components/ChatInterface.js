import React, { useState, useRef, useEffect } from 'react';
import { FiSend, FiCpu, FiUser } from 'react-icons/fi';
import './ChatInterface.css';

function ChatInterface() {
  const [messages, setMessages] = useState([
    {
      role: 'assistant',
      content: "Hello! I'm AskEd 🤖 — your AI assistant for university student services. How can I help you today?",
    },
  ]);
  const [input, setInput] = useState('');
  const [loading, setLoading] = useState(false);
  const messagesEndRef = useRef(null);

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' });
  };

  useEffect(() => {
    scrollToBottom();
  }, [messages]);

  // Simulated AI replies
  const getAIResponse = (message) => {
    const msg = message.toLowerCase();

    if (msg.includes('admission')) {
      return '🎓 You can apply for admission through the university portal. The last date for applications is **November 15th**.';
    } else if (msg.includes('course')) {
      return '📘 We offer 120+ courses across various departments. You can explore them on the official courses page.';
    } else if (msg.includes('fees')) {
      return '💰 The semester fee is **₹45,000** for UG programs and **₹60,000** for PG programs.';
    } else if (msg.includes('library')) {
      return '📚 The library is open from **8 AM to 10 PM** on weekdays and **9 AM to 5 PM** on weekends.';
    } else if (msg.includes('placement')) {
      return '💼 Our average placement rate is **92%**, with top recruiters like Infosys, Deloitte, and TCS.';
    } else {
      return "🤖 I'm here to help with admissions, courses, fees, or placements. Could you clarify your question?";
    }
  };

  const handleSend = (e) => {
    e.preventDefault();
    if (!input.trim() || loading) return;

    const userMessage = input.trim();
    setInput('');
    setLoading(true);

    setMessages((prev) => [...prev, { role: 'user', content: userMessage }]);

    // Fake AI response delay
    setTimeout(() => {
      const aiResponse = getAIResponse(userMessage);
      setMessages((prev) => [...prev, { role: 'assistant', content: aiResponse }]);
      setLoading(false);
    }, 1000);
  };

  return (
    <div className="chat-container">
      <div className="chat-messages">
        {messages.map((msg, idx) => (
          <div key={idx} className={`message ${msg.role}`}>
            <div className="message-icon">
              {msg.role === 'user' ? <FiUser /> : <FiCpu />}
            </div>
            <div className="message-content">
              <div className="message-text">{msg.content}</div>
            </div>
          </div>
        ))}
        {loading && (
          <div className="message assistant">
            <div className="message-icon"><FiCpu /></div>
            <div className="message-content">
              <div className="message-text typing-indicator">
                <span></span><span></span><span></span>
              </div>
            </div>
          </div>
        )}
        <div ref={messagesEndRef} />
      </div>

      <form className="chat-input-form" onSubmit={handleSend}>
        <input
          type="text"
          className="chat-input"
          value={input}
          onChange={(e) => setInput(e.target.value)}
          placeholder="Ask me about admissions, courses, or placements..."
          disabled={loading}
        />
        <button type="submit" className="send-button" disabled={loading || !input.trim()}>
          <FiSend />
        </button>
      </form>
    </div>
  );
}

export default ChatInterface;
