package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.security.core.Authentication;

/**
 * Demo 3 & 4: Frontend Integration Controllers
 * Controllers for Thymeleaf and JSP demo pages
 */
@Controller
public class FrontendDemoController {

    @GetMapping("/thymeleaf-demo")
    public String thymeleafDemo(Model model, Authentication authentication) {
        if (authentication != null) {
            model.addAttribute("user", authentication.getName());
            model.addAttribute("authorities", authentication.getAuthorities());
        }
        return "thymeleaf-demo";
    }

    @GetMapping("/jsp-demo")
    public String jspDemo(Model model, Authentication authentication) {
        if (authentication != null) {
            model.addAttribute("user", authentication.getName());
            model.addAttribute("authorities", authentication.getAuthorities());
        }
        return "jsp-demo"; // This will resolve to jsp-demo.jsp
    }
}