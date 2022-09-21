package com.demo.controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.demo.jpa.entity.Skill;
import com.demo.service.SkillService;

@RestController
@RequestMapping(value = "/skill")
public class SkillController {

	@Autowired
	private SkillService skillService;

	@GetMapping(value = "/{id}")
	public ResponseEntity<Optional<Skill>> findByIdJpa(@PathVariable("id") long id) {
		Optional<Skill> skill = skillService.findByIdJpa(id);
		return new ResponseEntity<>(skill, HttpStatus.OK);
	}
}
