from app.settings import Settings
settings = Settings()

# First detect if we should invoke OpenAI via MS Azure or directly
try:
    go_azure = settings.USE_MS_AZURE
except Exception as e:
    go_azure = False

if settings.BACKEND == "OpenAI":
    from app.summarizer import Summarizer

    summarizer = Summarizer(API_KEY=settings.OPENAI_API_KEY, go_azure=go_azure, model='gpt-3.5-turbo-16k',
                            max_tokens=500)

elif settings.BACKEND == "LangChain":
    from app.summarizerlangchain import Summarizer
    #TODO: fix this later
    summarizer = Summarizer(API_KEY=settings.OPENAI_API_KEY, go_azure=go_azure, model='gpt-3.5-turbo-16k',
                            max_tokens=500)

