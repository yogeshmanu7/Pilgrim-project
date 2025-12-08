package com.pilgrim.dto;

import java.util.List;

public class ChatRequest {

    private String message;
    private List<String> history; // optional: previous user messages

    public ChatRequest() {
        // default constructor needed by Jackson
    }

    public String getMessage() { 
        return message; 
    }

    public void setMessage(String message) { 
        this.message = message; 
    }

    public List<String> getHistory() { 
        return history; 
    }

    public void setHistory(List<String> history) { 
        this.history = history; 
    }
}

