package com.itbank.component;

import java.util.Random;

import org.springframework.stereotype.Component;

@Component
public class RandomNumberGenerator {

    private static final int LENGTH = 6;

    public String generateRandomNumberString() {
        Random random = new Random();
        StringBuilder sb = new StringBuilder(LENGTH);
        
        for (int i = 0; i < LENGTH; i++) {
            sb.append(random.nextInt(10));
        }

        return sb.toString();
    }
}