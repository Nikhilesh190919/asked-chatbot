# Ecoroute AI – RAG-Based AI Chatbot for University Student Services

A full-stack AI chatbot web application built with React (frontend) and FastAPI (backend) that provides intelligent responses to university-related queries.

## 🚀 Quick Deploy to AWS App Runner

**Want to deploy now?** See [QUICK_START.md](./QUICK_START.md) for the fastest path!

## Features

- 💬 **Chat Interface**: Interactive chat interface with send/receive message functionality
- 🤖 **AI Responses**: Simulated AI system with responses for university services
- 📊 **Admin Dashboard**: Analytics dashboard with mock statistics and popular questions
- 🎨 **Professional Dark Mode**: Beautiful, modern dark theme UI
- 📱 **Responsive Design**: Works seamlessly on desktop and mobile devices

## Tech Stack

### Frontend
- React 18
- React Icons
- CSS3 (Custom styling with dark mode theme)

### Backend (Optional)
- FastAPI
- Python 3.8+
- Pydantic for data validation
- Uvicorn ASGI server

## Local Development

### Frontend
```bash
cd frontend
npm install
npm start
```

### Backend (Optional)
```bash
cd backend
pip install -r requirements.txt
python main.py
```

## Project Structure

```
ecoroute-ai/
├── frontend/           # React application
│   ├── src/
│   │   ├── components/ # React components
│   │   └── App.js     # Main app component
│   ├── Dockerfile     # Docker configuration for App Runner
│   └── package.json
├── backend/           # FastAPI backend (optional)
│   ├── main.py
│   └── requirements.txt
├── Dockerfile         # Root Dockerfile for App Runner
├── apprunner.yaml     # App Runner configuration
├── deploy.sh          # Deployment helper script
└── DEPLOYMENT.md      # Detailed deployment guide
```

## Deployment

### AWS App Runner Deployment

1. **Create GitHub Repository** (public)
2. **Push code**: Run `./deploy.sh` or follow manual steps
3. **Set up App Runner**: Connect GitHub repo in AWS Console
4. **Get live URL**: Available in App Runner console after deployment

See [DEPLOYMENT.md](./DEPLOYMENT.md) for detailed instructions.

## Features Overview

### Chat Interface
- Real-time messaging with typing indicators
- Dark mode ChatGPT-style interface
- Responsive design for all devices

### Admin Dashboard
- Analytics with key metrics
- Popular questions tracking
- Performance monitoring

## Environment Variables

The app currently runs standalone. If you need to connect to the backend API:

```bash
REACT_APP_API_URL=https://your-api-url.com
```

## License

This project is created for demonstration purposes.

## Support

For deployment issues, see:
- [QUICK_START.md](./QUICK_START.md) - Fast deployment guide
- [DEPLOYMENT.md](./DEPLOYMENT.md) - Detailed instructions
