package com.pilgrim.controller;

import com.pilgrim.dto.ChatRequest;
import com.pilgrim.dto.ChatResponse;
import com.pilgrim.service.ChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnBean;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/chat")
@CrossOrigin(origins = "*") // allow front-end from anywhere (for testing)
public class ChatController {

    @Autowired(required = false)
    private ChatService chatService;

    @PostMapping
    public ChatResponse chat(@RequestBody ChatRequest request) {
        if (chatService == null) {
            return new ChatResponse("Chat service is not available. Please configure OpenAI API key and add the OpenAI Java client dependency.");
        }
        String reply = chatService.chat(request); // must return a non-null String
        return new ChatResponse(reply);
    }
}

