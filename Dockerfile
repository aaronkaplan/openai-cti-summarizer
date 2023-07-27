FROM python:3.11-bullseye as openai

# create a working directory
RUN mkdir /app
WORKDIR /app

# copy the requirements.txt file
COPY requirements_base.txt .

# install the base dependencies
RUN pip install -r requirements_base.txt
RUN pip install openai==0.27.8

# copy the main files
COPY . .
COPY .env .

ARG PORT=9999
ARG HOST=0.0.0.0

ENV PORT=$PORT
ENV HOST=$HOST
# expose the port for the FastAPI application
EXPOSE $PORT

# run the FastAPI application
CMD ["uvicorn", "app.main:app", "--reload", "--host", "0.0.0.0", "--port", "9999"]

FROM python:3.11-bullseye as langchain

# create a working directory
RUN mkdir /app
WORKDIR /app

# copy the requirements.txt file
COPY requirements_base.txt .

# install the base dependencies
RUN pip install -r requirements_base.txt
RUN pip install langchain[llms]

# copy the main files
COPY . .
COPY .env .

ARG PORT=9999
ARG HOST=0.0.0.0

ENV PORT=$PORT
ENV HOST=$HOST
# expose the port for the FastAPI application
EXPOSE $PORT

# run the FastAPI application
CMD ["uvicorn", "app.main:app", "--reload", "--host", "0.0.0.0", "--port", "9999"]
