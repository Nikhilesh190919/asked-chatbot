# AskEd – RAG-Based AI Chatbot for University Student Services

A full-stack AI chatbot web application built with React (frontend) and FastAPI (backend) that provides intelligent responses to university-related queries using simulated RAG (Retrieval-Augmented Generation) technology.

## Features

- 💬 **Chat Interface**: Interactive chat interface with send/receive message functionality
- 🤖 **RAG-Based Responses**: Simulated RAG system with mock knowledge base for university services
- 📊 **Admin Dashboard**: Analytics dashboard with mock statistics and popular questions
- 🎨 **Professional Dark Mode**: Beautiful, modern dark theme UI
- 📱 **Responsive Design**: Works seamlessly on desktop and mobile devices

## Tech Stack

### Frontend
- React 18
- Axios for API calls
- React Icons
- CSS3 (Custom styling with dark mode theme)

### Backend
- FastAPI
- Python 3.8+
- Pydantic for data validation
- Uvicorn ASGI server

## Project Structure

```
AskEd-Chatbot/
├── backend/
│   ├── main.py              # FastAPI application
│   └── requirements.txt      # Python dependencies
├── frontend/
│   ├── public/
│   │   └── index.html
│   ├── src/
│   │   ├── components/
│   │   │   ├── ChatInterface.js
│   │   │   ├── ChatInterface.css
│   │   │   ├── AdminDashboard.js
│   │   │   └── AdminDashboard.css
│   │   ├── App.js
│   │   ├── App.css
│   │   ├── index.js
│   │   └── index.css
│   └── package.json
└── README.md
```

## Installation & Setup

### Backend Setup

1. Navigate to the backend directory:
```bash
cd backend
```

2. Create a virtual environment (recommended):
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

3. Install dependencies:
```bash
pip install -r requirements.txt
```

4. Run the FastAPI server:
```bash
python main.py
```

The backend will be running at `http://localhost:8000`

### Frontend Setup

1. Navigate to the frontend directory:
```bash
cd frontend
```

2. Install dependencies:
```bash
npm install
```

3. Start the development server:
```bash
npm start
```

The frontend will be running at `http://localhost:3000`

## API Endpoints

### POST `/api/chat`
Send a chat message and receive a RAG-based response.

**Request:**
```json
{
  "message": "What are the tuition fees?",
  "conversation_id": "optional_conversation_id"
}
```

**Response:**
```json
{
  "response": "Based on our university resources, Tuition fees vary...",
  "sources": [
    {
      "title": "Bursar's Office - Fee Schedule 2024",
      "relevance": 0.95
    }
  ],
  "conversation_id": "conv_1234567890"
}
```

### GET `/api/analytics`
Get mock analytics data for the admin dashboard.

**Response:**
```json
{
  "total_queries": 2345,
  "active_users": 156,
  "popular_questions": [...],
  "response_time_avg": 1.2,
  "satisfaction_score": 4.6
}
```

## Usage

1. **Chat Interface**: 
   - Type your question in the chat input
   - Press Enter or click the send button
   - Receive AI-powered responses with source citations

2. **Admin Dashboard**:
   - View real-time analytics
   - Check popular questions
   - Monitor system performance metrics

## Mock Knowledge Base Topics

The chatbot can answer questions about:
- Admissions
- Tuition and fees
- Course registration
- Housing
- Library services
- Financial aid
- Academic calendar
- Campus facilities

## Development Notes

- The RAG system uses simple keyword matching for demonstration purposes
- All analytics data is randomly generated for demo purposes
- The backend uses CORS middleware to allow frontend connections
- Conversation IDs are generated automatically for session tracking

## License

This project is created for demonstration purposes.

