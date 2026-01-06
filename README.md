# 📚 GhostMicro Library Documents

**Official Documentation & API References for the GhostMicro Ecosystem.**

This repository hosts the centralized technical documentation for all GhostMicro libraries, firmware protocols, and hardware standards. It is built using **MkDocs** with the **Material for MkDocs** theme to ensure a fast, responsive, and beautiful reading experience.

---

## 🚀 Getting Started

### Prerequisites
- Python 3.x
- `pip` package manager

### Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/gridsmicro/GhostMicro-Library-Documents.git
    cd GhostMicro-Library-Documents
    ```

2.  **Install dependencies**:
    ```bash
    pip install mkdocs-material
    ```

### Local Development

To run the documentation server locally with live reload (Port 8081 to avoid conflict with Genesis Core):
```bash
mkdocs serve -a 127.0.0.1:8081
```
> Open [http://127.0.0.1:8081](http://127.0.0.1:8081) in your browser.

### Offline Viewing (Static Files)

Since we configured `use_directory_urls: false`, you can view the docs offline:
1. Build the site: `mkdocs build`
2. Open `site/index.html` directly in your browser.

### Building for Production

To build the static site (HTML/CSS):
```bash
mkdocs build
```
The output will be in the `site/` directory, ready for deployment to GitHub Pages or any static host.

---

## 📂 Structure

- `docs/`: Markdown source files.
- `mkdocs.yml`: Configuration file (Theme, Nav, Plugins).
- `site/`: Generated static site (do not edit manually).

---
*GhostMicro Infrastructure Team*
