package com.pilgrim.service;

import com.pilgrim.dto.ChatRequest;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.stereotype.Service;

@Service
@ConditionalOnProperty(name = "openai.api.key")
public class ChatService {

    private final String apiKey;

    public ChatService(@Value("${openai.api.key:}") String apiKey) {
        this.apiKey = apiKey;
    }

    public String chat(ChatRequest request) {
        // OpenAI client library not available - return a helpful message
        return "Chat service is currently unavailable. Please configure OpenAI API key and add the OpenAI Java client dependency to enable this feature.";
    }
}

