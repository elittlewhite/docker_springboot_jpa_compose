package com.demo.jpa.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.demo.jpa.entity.Skill;

public interface SkillRepository extends JpaRepository<Skill, Long> {
}
