package feature.bid.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.io.Serial;
import java.io.Serializable;
import java.util.Date;

@Entity(name = "BID_EVENT")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class BidEventVo implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "BID_EVENT_NO")
    private Integer bidEventNo;

    @Column(name = "BID_ITEM_NO")
    private String bidItemNo;

    @Column(name = "FLOOR_PRICE")
    private Integer floorPrice;

    @Column(name = "LEAST_OFFERS")
    private Integer leastOffers;

    @Column(name = "START_TIME")
    private Date startTime;

    @Column(name = "CLOSE_TIME")
    private Date closeTime;

    @Column(name = "DIRECTIVE_PRICE")
    private Integer directivePrice;

}
