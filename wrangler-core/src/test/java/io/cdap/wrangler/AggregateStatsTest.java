package io.cdap.wrangler;

import org.junit.Test;
import static org.junit.Assert.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Sample test for the AggregateStats directive.
 */
public class AggregateStatsTest {
    @Test
    public void testAggregate() {
        // Sample data rows
        List<Row> rows = new ArrayList<>();
        rows.add(Row.create(0, "data", "100KB", "50ms"));
        rows.add(Row.create(1, "data", "200KB", "100ms"));

        // Recipe command string
        String[] recipe = {
            "aggregate-stats :data_transfer_size :response_time total_size_mb total_time_sec"
        };

        // Execute the recipe
        TestingRig rig = new TestingRig();
        List<Row> results = rig.execute(recipe, rows);

        // Validate results
        assertEquals(1, results.size());
        assertEquals(0.3, results.get(0).getValue("total_size_mb"), 0.001);
        assertEquals(0.15, results.get(0).getValue("total_time_sec"), 0.001);
    }
}
