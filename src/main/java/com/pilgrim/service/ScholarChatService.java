package com.pilgrim.service;

import com.pilgrim.entity.ScholarBooking;
import com.pilgrim.entity.ScholarChat;
import com.pilgrim.entity.User;
import com.pilgrim.repository.ScholarChatRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class ScholarChatService {
    
    @Autowired
    private ScholarChatRepository chatRepository;
    
    public ScholarChat sendMessage(User sender, User receiver, ScholarBooking booking, String message) {
        ScholarChat chat = new ScholarChat();
        chat.setSender(sender);
        chat.setReceiver(receiver);
        chat.setBooking(booking);
        chat.setMessage(message);
        return chatRepository.save(chat);
    }
    
    public List<ScholarChat> getConversation(User user1, User user2) {
        return chatRepository.findConversation(user1, user2);
    }
    
    public List<ScholarChat> getUnreadMessages(User receiver) {
        return chatRepository.findUnreadMessages(receiver);
    }
    
    public void markAsRead(Long chatId) {
        ScholarChat chat = chatRepository.findById(chatId)
            .orElseThrow(() -> new RuntimeException("Chat not found"));
        chat.setIsRead(true);
        chatRepository.save(chat);
    }
}

