package io.cdap.wrangler.parser;

import org.junit.Test;
import static org.junit.Assert.*;

public class TimeDurationTest {
    @Test
    public void testParse() {
        assertEquals(1_000_000L, new TimeDuration("1ms").getNanos());
        assertEquals(1_000_000_000L, new TimeDuration("1s").getNanos());
        assertEquals(60_000_000_000L, new TimeDuration("1min").getNanos());
        assertEquals(3_600_000_000_000L, new TimeDuration("1hr").getNanos());
        // Add more test cases as needed
    }
}
