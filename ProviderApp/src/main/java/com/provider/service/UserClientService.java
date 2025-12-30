package com.provider.service;


import com.provider.model.UserDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.List;

@Service
public class UserClientService {

    @Autowired
    private RestTemplate restTemplate;

    // Base URL of User Management Application
    private static final String USER_SERVICE_URL = "http://localhost:8080/api/users";

    /**
     * Fetch all users from User Management App
     */
    public List<UserDTO> getAllUsers() {
        try {
            ResponseEntity<List<UserDTO>> response = restTemplate.exchange(
                    USER_SERVICE_URL,
                    HttpMethod.GET,
                    null,
                    new ParameterizedTypeReference<List<UserDTO>>() {}
            );
            return response.getBody();
        } catch (Exception e) {
            System.err.println("Error fetching all users: " + e.getMessage());
            throw new RuntimeException("Failed to fetch users from User Management Service", e);
        }
    }

    /**
     * Fetch a single user by ID
     */
    public UserDTO getUserById(Long id) {
        try {
            String url = USER_SERVICE_URL + "/" + id;
            ResponseEntity<UserDTO> response = restTemplate.getForEntity(url, UserDTO.class);
            return response.getBody();
        } catch (Exception e) {
            System.err.println("Error fetching user " + id + ": " + e.getMessage());
            return null;
        }
    }

    /**
     * Create a new user
     */
    public UserDTO createUser(UserDTO user) {
        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            HttpEntity<UserDTO> request = new HttpEntity<>(user, headers);

            ResponseEntity<UserDTO> response = restTemplate.postForEntity(
                    USER_SERVICE_URL,
                    request,
                    UserDTO.class
            );
            return response.getBody();
        } catch (Exception e) {
            System.err.println("Error creating user: " + e.getMessage());
            throw new RuntimeException("Failed to create user", e);
        }
    }

    /**
     * Update an existing user
     */
    public UserDTO updateUser(Long id, UserDTO user) {
        try {
            String url = USER_SERVICE_URL + "/" + id;

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            HttpEntity<UserDTO> request = new HttpEntity<>(user, headers);

            ResponseEntity<UserDTO> response = restTemplate.exchange(
                    url,
                    HttpMethod.PUT,
                    request,
                    UserDTO.class
            );
            return response.getBody();
        } catch (Exception e) {
            System.err.println("Error updating user " + id + ": " + e.getMessage());
            throw new RuntimeException("Failed to update user", e);
        }
    }

    /**
     * Delete a user
     */
    public boolean deleteUser(Long id) {
        try {
            String url = USER_SERVICE_URL + "/" + id;
            restTemplate.delete(url);
            return true;
        } catch (Exception e) {
            System.err.println("Error deleting user " + id + ": " + e.getMessage());
            return false;
        }
    }
}
