package com.demo.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.jpa.entity.Skill;
import com.demo.jpa.repository.SkillRepository;

@Service
public class SkillService {

	@Autowired
	private SkillRepository skillRepository;
	
	public Optional<Skill> findByIdJpa(long id) {
		return skillRepository.findById(id);
	}
}
