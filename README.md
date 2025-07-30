# 🎵 Spotify Clone - MVVM Architecture

A full-stack music streaming application built with Flutter and FastAPI, featuring a modern MVVM architecture and comprehensive music management capabilities.

![Spotify Clone](https://img.shields.io/badge/Platform-Flutter-02569B?style=for-the-badge&logo=flutter)
![FastAPI](https://img.shields.io/badge/Backend-FastAPI-009688?style=for-the-badge&logo=fastapi)
![Docker](https://img.shields.io/badge/Database-Docker-2496ED?style=for-the-badge&logo=docker)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql)

## 📱 Features

### 🎼 Music Management
- **Upload Songs**: Upload your favorite tracks with custom thumbnails and metadata
- **Stream Music**: High-quality audio streaming with background playback support
- **Search Functionality**: Find songs quickly with powerful search capabilities
- **Recently Played**: Track and display your listening history

### 👤 User Experience
- **User Authentication**: Secure login and registration system
- **Profile Management**: View and edit user profiles
- **Personalized Homepage**: Curated music feed based on user preferences
- **Responsive Design**: Optimized for various screen sizes

### 🎨 Modern UI/UX
- **Dark Theme**: Eye-friendly dark mode interface
- **Smooth Animations**: Fluid transitions and interactions
- **Audio Visualizations**: Dynamic audio wave displays
- **Intuitive Navigation**: User-friendly interface design

## 🏗️ Architecture

### Client-Side (Flutter)
- **MVVM Pattern**: Clean separation of concerns
- **Riverpod State Management**: Reactive state management solution
- **Repository Pattern**: Clean data layer abstraction
- **Dependency Injection**: Loosely coupled components

### Server-Side (FastAPI)
- **RESTful API**: Clean and scalable API endpoints
- **PostgreSQL Database**: Robust data persistence
- **Docker Containerization**: Easy deployment and development
- **JWT Authentication**: Secure token-based authentication

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (≥3.0.0)
- Python (≥3.8)
- Docker & Docker Compose
- PostgreSQL

### 🛠️ Backend Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/Huste6/spotify_app_flutter.git
   cd spotify-clone/server
   ```

2. **Start the database with Docker**
   ```bash
   docker compose up -d --build
   ```

3. **Access PostgreSQL Admin UI**
   ```
   URL: http://localhost:5050/
   ```
   Use the credentials from your `docker-compose.yml` file to login.

4. **Install Python dependencies**
   ```bash
   pip install -r requirements.txt
   ```

5. **Run the FastAPI server**
   ```bash
   uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
   ```

6. **API Documentation**
   ```
   Swagger UI: http://localhost:8000/docs
   ```

### 📱 Frontend Setup

1. **Navigate to client directory**
   ```bash
   cd ../client
   ```

2. **Install Flutter dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code (if using code generation)**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the application**
   ```bash
   flutter run
   ```

## 📂 Project Structure

```
spotify-clone/
├── server/                 # FastAPI Backend
│   ├── app/
│   │   ├── models/        # Database models
│   │   ├── routers/       # API endpoints
│   │   ├── database.py    # Database configuration
│   │   └── main.py        # FastAPI app entry point
│   ├── docker-compose.yml # Docker services
│   └── requirements.txt   # Python dependencies
│
└── client/                # Flutter Frontend
    ├── lib/
    │   ├── core/          # Core utilities and providers
    │   ├── features/      # Feature-based modules
    │   │   ├── auth/      # Authentication
    │   │   ├── home/      # Homepage & music management
    │   │   ├── profile/   # User profile
    │   │   └── search/    # Search functionality
    │   └── main.dart      # App entry point
    └── pubspec.yaml       # Flutter dependencies
```

## 🎯 Core Features Implementation

### 🔐 Authentication System
- JWT-based secure authentication
- User registration and login
- Token refresh mechanism
- Protected routes and middleware

### 🎵 Music Streaming
- File upload with validation
- Audio streaming with Just Audio
- Background playback support
- Progress tracking and controls

### 🔍 Search & Discovery
- Real-time search functionality
- Filter by artist, song name, or genre
- Search history and suggestions
- Trending and popular tracks

### 👤 Profile Management
- User profile customization
- Upload profile pictures
- Edit personal information
- View listening statistics

## 🛡️ Security Features

- **JWT Authentication**: Secure token-based authentication
- **Input Validation**: Server-side request validation
- **CORS Configuration**: Proper cross-origin resource sharing
- **File Upload Security**: Safe file handling and validation

## 🎨 UI/UX Highlights

- **Material Design 3**: Modern Android design principles
- **Custom Animations**: Smooth page transitions and micro-interactions
- **Responsive Layout**: Adaptive design for different screen sizes
- **Accessibility**: WCAG compliant interface design

## 📊 API Endpoints

### Authentication
- `POST /auth/register` - User registration
- `POST /auth/login` - User login
- `GET /auth/me` - Get current user

### Songs
- `GET /songs` - Get all songs
- `POST /songs` - Upload new song
- `GET /songs/{id}` - Get specific song
- `GET /songs/search` - Search songs

### User Profile
- `GET /profile` - Get user profile
- `PUT /profile` - Update user profile
- `POST /profile/avatar` - Upload profile picture


---

<div align="center">
  <img src="https://img.shields.io/badge/Made%20with-❤️-red.svg"/>
  <img src="https://img.shields.io/badge/Flutter-Framework-blue.svg"/>
  <img src="https://img.shields.io/badge/FastAPI-Backend-green.svg"/>
</div>