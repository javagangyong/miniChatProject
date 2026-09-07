package com.itbank.component;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.springframework.stereotype.Component;

@Component
public class HashComponent {
   
   public String getHash(String input) {
      MessageDigest md;
      String output = null;
      try {
         md = MessageDigest.getInstance("SHA-512");
         md.update(input.getBytes());
         output = String.format("%0128x", new BigInteger(1, md.digest()));
         
      } catch (NoSuchAlgorithmException e) {
         e.printStackTrace();
      }
      
      return output;
   }

}
