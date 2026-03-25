# TrueGuard: LLM Hallucination Detection & Mitigation Framework
# Proof of Concept (PoC) for Capstone Project

import os
import json
import requests

# NOTE: Since your laptop has limited resources (Celeron N4500, 8GB RAM), 
# this script uses Cloud APIs instead of running heavy models locally.
# Example configured for GROQ API (fast, free open-source model inference)

GROQ_API_KEY = os.getenv("GROQ_API_KEY", "your_groq_api_key_here")
API_URL = "https://api.groq.com/openai/v1/chat/completions"

def call_llm(prompt, model="llama3-8b-8192"):
    """
    Submits a prompt to a Baseline LLM.
    """
    headers = {
        "Authorization": f"Bearer {GROQ_API_KEY}",
        "Content-Type": "application/json"
    }
    payload = {
        "model": model,
        "messages": [{"role": "user", "content": prompt}],
        "temperature": 0.3
    }
    try:
        response = requests.post(API_URL, headers=headers, json=payload)
        response.raise_for_status()
        return response.json()['choices'][0]['message']['content'].strip()
    except Exception as e:
        return f"Error calling API: {str(e)}"

def trueguard_evaluate(prompt, generated_response):
    """
    Core TrueGuard Architecture Logic.
    Evaluates the response for factual/logical inconsistencies 
    using a secondary evaluator pipeline.
    """
    evaluator_prompt = f"""
    You are TRUEGUARD, an advanced hallucination detection framework.
    Analyze the following user prompt and the generated response.
    Determine if the response contains any factual, logical, or intent-based hallucinations.
    
    User Prompt: {prompt}
    Generated Response: {generated_response}
    
    Provide your analysis strictly in JSON format:
    {{
        "is_hallucinating": true/false,
        "hallucination_type": "None/Factual/Logical/Intent",
        "confidence_score": 0.0-1.0,
        "explanation": "Brief reasoning"
    }}
    """
    # TRUEGUARD uses a more powerful model acting as an evaluator
    evaluation = call_llm(evaluator_prompt, model="llama3-70b-8192")
    return evaluation

def main():
    print("=========================================")
    print("      TRUEGUARD FRAMEWORK TESTING        ")
    print("=========================================")
    
    # 1. Tricky prompt to induce hallucination
    test_prompt = "Who was the first person to walk on Mars, and what were his first words?"
    print(f"\n[USER PROMPT]:\n{test_prompt}")
    
    # 2. Baseline Model Response
    print("\n[GENERATED RESPONSE (BASELINE)]:")
    response = call_llm(test_prompt)
    print(response)
    
    # 3. TrueGuard Interception and Analysis
    print("\n[TRUEGUARD ANALYSIS]:")
    analysis = trueguard_evaluate(test_prompt, response)
    
    try:
        # Parse the JSON response nicely if possible
        analysis_data = json.loads(analysis)
        print(json.dumps(analysis_data, indent=4))
    except:
        print(analysis)
    
if __name__ == "__main__":
    main()
