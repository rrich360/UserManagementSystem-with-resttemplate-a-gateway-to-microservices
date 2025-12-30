package com.usermanagement.example.config;


import com.usermanagement.example.model.User;
import com.usermanagement.example.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;

@Component
public class DataInitializer {

    @Autowired
    private UserRepository userRepository;

    @PostConstruct
    public void init() {
        // Only add default users if database is empty
        if (userRepository.count() == 0) {
            User user1 = new User();
            user1.setUsername("johndoe");
            user1.setEmail("john@example.com");
            user1.setFirstName("John");
            user1.setLastName("Doe");
            user1.setPhone("555-1234");
            userRepository.save(user1);

            User user2 = new User();
            user2.setUsername("janedoe");
            user2.setEmail("jane@example.com");
            user2.setFirstName("Jane");
            user2.setLastName("Doe");
            user2.setPhone("555-5678");
            userRepository.save(user2);

            System.out.println("Default users created successfully!");
        }
    }
}
