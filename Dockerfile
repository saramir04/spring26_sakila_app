# Use lightweight image
FROM python:3.9-slim

# Metadata
LABEL maintainer="Sara" \
      version="1.0" \
      description="Optimized Sakila Flask Application"

# Set working directory
WORKDIR /app

# Copy dependency file first (for caching)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Create non-root user
RUN useradd -m appuser
USER appuser

# Expose only required port
EXPOSE 5000

# Health check
HEALTHCHECK CMD curl --fail http://localhost:5000 || exit 1

# Run application
CMD ["python", "app.py"]