# 💡 BrightBites

**Bite-Sized Learning Adventures** - Your curated collection of articles, videos, and skill snacks for learning AI, coding, and technology.

Join in my AI journey by checking out BrightBites https://msjammu.github.io/BrightBites/

## 🌟 What is BrightBites?

BrightBites is a beautiful, interactive learning hub that helps you organize and track your educational journey in tech. It's designed for developers, students, and lifelong learners who want to:

- 📚 Curate articles and videos from across the web
- 🎯 Track learning goals with "Skill Snacks" (learning todos)
- 🏷️ Filter content by tags and topics
- 🔍 Search across all your saved resources
- 📱 Enjoy a modern, responsive interface

## ✨ Features

### 📖 Resource Library
- **Articles & Videos**: Save and organize content from your favorite sources
- **Smart Filtering**: Filter by content type (articles, YouTube videos) and tags
- **Inline Video Player**: Watch YouTube videos without leaving the page
- **Search**: Quickly find resources by title, author, channel, or tags

### 🍎 Skill Snacks (Learning Todos)
- Track what you want to learn next
- Add context with "Why Learn" descriptions
- Link todos to relevant resources with tags
- Mark items as completed to track your progress

### 🎨 Beautiful UI
- Dark mode interface optimized for focus
- Smooth animations and transitions
- Mobile-responsive design
- Accessibility-friendly

## 🚀 Getting Started

### Option 1: Use Directly (Recommended)
1. Clone this repository
2. Edit `data.js` to add your articles and videos
3. Edit `todos.js` to add your learning goals
4. Open `index.html` in your browser or deploy to GitHub Pages

### Option 2: GitHub Pages Deployment
1. Fork this repository
2. Go to Settings → Pages
3. Select the `main` branch as the source
4. Your site will be live at `https://yourusername.github.io/BrightBites`

## 📝 How to Add Content

### Adding Articles or Videos

Edit `data.js` and add entries to the `RESOURCES` array:

```javascript
// Article example
{
  type: 'article',
  title: 'Your Article Title',
  url: 'https://example.com/article',
  author: 'Author Name',
  date: '2024-11-24',
  image: 'https://example.com/image.jpg',
  tags: ['ai', 'tutorial', 'beginner']
}

// Video example
{
  type: 'video',
  title: 'Your Video Title',
  youtubeId: 'VIDEO_ID',
  channel: 'Channel Name',
  date: '2024-11-24',
  tags: ['python', 'programming']
}
```

### Adding Learning Goals (Skill Snacks)

Edit `todos.js` and add entries to the `LEARNING_TODOS` array:

```javascript
{
  id: Date.now(), // Unique ID
  text: "Learn React Hooks",
  icon: "⚛️",
  whyLearn: "Master modern React patterns for building scalable UIs",
  tags: ["react", "javascript", "frontend"],
  completed: false,
  createdAt: new Date().toISOString()
}
```

## 🛠️ Tools

### YouTube Metadata Helper

The `tools/Get-YouTubeMetadata.ps1` PowerShell script helps you quickly add YouTube videos:

```powershell
# Load the script
. .\tools\Get-YouTubeMetadata.ps1

# Get formatted entry for data.js
Add-YouTubeVideoToData -VideoUrl "https://www.youtube.com/watch?v=VIDEO_ID" -Tags @('ai', 'tutorial')
```

This automatically fetches video title, channel, upload date, and thumbnail!

## 📂 Project Structure

```
BrightBites/
├── index.html          # Main application file
├── data.js            # Your articles and videos
├── todos.js           # Your learning goals
├── README.md          # This file
├── assets/            # Empty folder for future assets
├── examples/          # Empty folder for examples
└── tools/
    └── Get-YouTubeMetadata.ps1  # YouTube helper script
```

## 🎯 Use Cases

- **Personal Learning Hub**: Track your self-education journey
- **Course Companion**: Organize resources for online courses
- **Research Collection**: Curate content for specific topics
- **Team Knowledge Base**: Share learning resources with your team
- **Student Portfolio**: Showcase your learning progress

## 🤝 Contributing

Feel free to fork this project and customize it for your needs! Some ideas:

- Add new content types (podcasts, books, courses)
- Implement export/import functionality
- Add progress tracking charts
- Create browser extension for easy bookmarking

## 📄 License

This project is open source and available under the MIT License.

## 🙏 Credits

Created with ❤️ for lifelong learners everywhere.

**Built with:**
- Vanilla JavaScript (no frameworks!)
- Google Fonts (Inter)
- YouTube Embed API

---

Happy Learning! 🚀✨
