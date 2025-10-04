package com.example.demo.service;

import com.example.demo.dto.LoginRequest;
import com.example.demo.dto.LoginResponse;
import com.example.demo.dto.RegisterRequest;
import com.example.demo.entity.Role;
import com.example.demo.entity.User;
import com.example.demo.repository.RoleRepository;
import com.example.demo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Set;

/**
 * Demo 5: JWT Authentication Service
 * Service xử lý đăng ký và đăng nhập với JWT
 */
@Service
public class AuthenticationService {
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private RoleRepository roleRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    @Autowired
    private AuthenticationManager authenticationManager;
    
    @Autowired
    private JwtService jwtService;

    public User signup(RegisterRequest input) {
        // Kiểm tra user đã tồn tại chưa
        if (userRepository.existsByUsername(input.getUsername())) {
            throw new RuntimeException("Tên đăng nhập đã tồn tại");
        }
        
        if (userRepository.existsByEmail(input.getEmail())) {
            throw new RuntimeException("Email đã được sử dụng");
        }

        // Tạo user mới
        User user = new User();
        user.setUsername(input.getUsername());
        user.setPassword(passwordEncoder.encode(input.getPassword()));
        user.setEmail(input.getEmail());
        user.setEnabled(true);
        
        // Gán role mặc định là USER
        Role userRole = roleRepository.findByName("USER")
                .orElseThrow(() -> new RuntimeException("Không tìm thấy role USER"));
        user.setRoles(Set.of(userRole));

        return userRepository.save(user);
    }

    public LoginResponse authenticate(LoginRequest input) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        input.getUsername(),
                        input.getPassword()
                )
        );

        User user = userRepository.findByUsername(input.getUsername())
                .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng"));

        String jwtToken = jwtService.generateToken(user);

        return new LoginResponse(jwtToken, jwtService.getExpirationTime(), user.getUsername());
    }
}