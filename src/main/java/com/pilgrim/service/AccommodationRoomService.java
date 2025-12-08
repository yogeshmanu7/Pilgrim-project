package com.pilgrim.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pilgrim.entity.Property;
import com.pilgrim.entity.Room;
import com.pilgrim.enums.RoomType;
import com.pilgrim.repository.PropertyRepository;
import com.pilgrim.repository.RoomRepository;

@Service
public class AccommodationRoomService {
	
	@Autowired
	private RoomRepository roomRepository;
	
	@Autowired
	private PropertyRepository propertyRepository;
	
	@Transactional
	public Room addRoom(Long propertyId, RoomType roomType, String customRoomType,
			Double roomSize, Integer bathrooms, Integer totalOccupancy, Integer totalRooms,
			BigDecimal minimumRoomRate, BigDecimal extraGuestPrice,
			Boolean breakfastIncluded, BigDecimal breakfastPricePerGuest) {
		Optional<Property> propertyOpt = propertyRepository.findById(propertyId);
		if (propertyOpt.isPresent()) {
			Room room = new Room();
			room.setProperty(propertyOpt.get());
			room.setRoomType(roomType);
			room.setCustomRoomType(customRoomType);
			room.setRoomSize(roomSize);
			room.setBathrooms(bathrooms);
			room.setTotalOccupancy(totalOccupancy);
			room.setTotalRooms(totalRooms);
			room.setMinimumRoomRate(minimumRoomRate);
			room.setExtraGuestPrice(extraGuestPrice);
			room.setBreakfastIncluded(breakfastIncluded);
			room.setBreakfastPricePerGuest(breakfastPricePerGuest);
			return roomRepository.save(room);
		}
		return null;
	}
	
	public List<Room> findByProperty(Long propertyId) {
		Optional<Property> propertyOpt = propertyRepository.findById(propertyId);
		if (propertyOpt.isPresent()) {
			return roomRepository.findByProperty(propertyOpt.get());
		}
		return List.of();
	}
	
	@Transactional
	public void deleteRoom(Long roomId) {
		roomRepository.deleteById(roomId);
	}
}

