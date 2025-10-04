package com.example.demo.init;

import com.example.demo.entity.Role;
import com.example.demo.entity.User;
import com.example.demo.repository.RoleRepository;
import com.example.demo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.Set;

/**
 * Demo 2: Data Initialization
 * Khởi tạo dữ liệu mẫu cho database
 */
@Component
public class DataInitializer implements CommandLineRunner {

    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private RoleRepository roleRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public void run(String... args) throws Exception {
        // Create roles if they don't exist
        Role adminRole = roleRepository.findByName("ADMIN")
                .orElseGet(() -> roleRepository.save(new Role("ADMIN", "Administrator role")));
        
        Role managerRole = roleRepository.findByName("MANAGER")
                .orElseGet(() -> roleRepository.save(new Role("MANAGER", "Manager role")));
        
        Role userRole = roleRepository.findByName("USER")
                .orElseGet(() -> roleRepository.save(new Role("USER", "Regular user role")));

        // Create users if they don't exist
        if (!userRepository.existsByUsername("admin")) {
            User admin = new User("admin", passwordEncoder.encode("admin123"), "admin@example.com");
            admin.setRoles(Set.of(adminRole));
            userRepository.save(admin);
        }

        if (!userRepository.existsByUsername("manager")) {
            User manager = new User("manager", passwordEncoder.encode("manager123"), "manager@example.com");
            manager.setRoles(Set.of(managerRole, userRole));
            userRepository.save(manager);
        }

        if (!userRepository.existsByUsername("user")) {
            User user = new User("user", passwordEncoder.encode("user123"), "user@example.com");
            user.setRoles(Set.of(userRole));
            userRepository.save(user);
        }

        System.out.println("Database initialized with sample users:");
        System.out.println("Admin: admin/admin123");
        System.out.println("Manager: manager/manager123");
        System.out.println("User: user/user123");
    }
}