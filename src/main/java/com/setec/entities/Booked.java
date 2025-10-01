package com.setec.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity(name = "tbl_booked")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Booked {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	private String name;
	private String phoneNumber;
	private String email;
	private String date;
	private String time;
	private int person;
	
	@Override
    public String toString() {
      return "✨ New Booking Alert! ✨\n\n" +
           "👤 Name: " + this.name + "\n" +
           "📞 Phone: " + this.phoneNumber + "\n" +
           "📧 Email: " + this.email + "\n" +
           "🗓 Date: " + this.date + "\n" +
           "⏰ Time: " + this.time + "\n" +
           "👨‍👩‍👧‍👦 People: " + this.person + "\n\n" +
           "✅ Booking saved successfully!";
    }
	
	

}
