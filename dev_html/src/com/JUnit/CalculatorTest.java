package com.JUnit;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class CalculatorTest {

	@Test
	void testPlus() {
		Calculator cal = new Calculator();
		assertEquals(10,cal.plus(5, 5));
	}

	@Test
	void testMinus() {
		Calculator cal = new Calculator();
		assertEquals(0,cal.minus(5, 5));
	}

	@Test
	void testMulti() {
		Calculator cal = new Calculator();
		assertEquals(25,cal.multi(5, 5));
	}

	@Test
	void testDiv() {
		Calculator cal = new Calculator();
		assertEquals(3,cal.div(6, 2));
	}

}
