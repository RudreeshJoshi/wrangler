package io.cdap.wrangler;

import io.cdap.wrangler.api.Directive;
import io.cdap.wrangler.api.DirectiveExecutor;
import io.cdap.wrangler.api.UsageDefinition;

/**
 * AggregateStats directive for summing data sizes and durations with unit conversions.
 */
public class AggregateStats implements Directive {

    private String sizeColumn;
    private String timeColumn;
    private String targetSizeColumn;
    private String targetTimeColumn;
    private String sizeUnit;
    private String timeUnit;
    private AggregationType aggregationType;

    @Override
    public void define(UsageDefinition usageDef) {
        usageDef.usage("aggregate-stats")
                .argument(UsageDefinition.argument("sourceSizeColumn").type(UsageDefinition.Type.COLUMN))
                .argument(UsageDefinition.argument("sourceTimeColumn").type(UsageDefinition.Type.COLUMN))
                .argument(UsageDefinition.argument("targetSizeColumn").type(UsageDefinition.Type.COLUMN))
                .argument(UsageDefinition.argument("targetTimeColumn").type(UsageDefinition.Type.COLUMN))
                .option(UsageDefinition.option("sizeUnit").type(UsageDefinition.Type.STRING))
                .option(UsageDefinition.option("timeUnit").type(UsageDefinition.Type.STRING))
                .option(UsageDefinition.option("aggregationType").type(UsageDefinition.Type.STRING));
    }

    @Override
    public DirectiveExecutor getExecutor() {
        return new AggregateStatsExecutor(
                sizeColumn,
                timeColumn,
                targetSizeColumn,
                targetTimeColumn,
                sizeUnit,
                timeUnit,
                aggregationType
        );
    }

    // Setters to initialize parameters during execution based on recipe parsing
    public void setSizeColumn(String sizeColumn) {
        this.sizeColumn = sizeColumn;
    }

    public void setTimeColumn(String timeColumn) {
        this.timeColumn = timeColumn;
    }

    public void setTargetSizeColumn(String targetSizeColumn) {
        this.targetSizeColumn = targetSizeColumn;
    }

    public void setTargetTimeColumn(String targetTimeColumn) {
        this.targetTimeColumn = targetTimeColumn;
    }

    public void setSizeUnit(String sizeUnit) {
        this.sizeUnit = sizeUnit;
    }

    public void setTimeUnit(String timeUnit) {
        this.timeUnit = timeUnit;
    }

    public void setAggregationType(AggregationType aggregationType) {
        this.aggregationType = aggregationType;
    }

    // You may add constructor, toString, or other methods as needed
}
