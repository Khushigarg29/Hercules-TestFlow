# Use an official Python 3.11 image based on Ubuntu
FROM python:3.11-slim

# # Install Playwright and dependencies
# RUN pip install -U playwright && \
#     playwright install --with-deps

# Set the working directory in the container
WORKDIR /testzeus-hercules

# Copy only the necessary files for installation
COPY pyproject.toml poetry.lock /testzeus-hercules/

# Install Poetry
RUN pip install poetry==1.8.4

# Install dependencies and the package
RUN poetry install --no-dev
RUN poetry run playwright install --with-deps

# Copy the rest of the project files
COPY . /testzeus-hercules

# Install Hercules
RUN poetry install

# Copy the entrypoint script and make it executable
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Define the entrypoint
ENTRYPOINT ["/entrypoint.sh"]
