package com.pilgrim.dto;

public class ChatResponse {

    private String reply;

    public ChatResponse() {
        // default constructor needed by Jackson (for safety)
    }

    public ChatResponse(String reply) { 
        this.reply = reply; 
    }

    public String getReply() { 
        return reply; 
    }

    public void setReply(String reply) { 
        this.reply = reply; 
    }
}

