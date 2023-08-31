package feature.bid.vo;

import feature.mem.vo.MemVo;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serial;
import java.io.Serializable;
@Entity
@Table(name = "BID_ORDER")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class BidOrderVo implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "BID_ORDER_NO")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer bidOrderNo;


    @Column(name = "FINAL_PRICE")
    private Integer finalPrice;

    @OneToOne
    @JoinColumn(name = "BID_EVENT_NO", updatable = false, insertable = false)
    private BidEventVo bidEventVo;

    @ManyToOne
    @JoinColumn(name = "MEM_NO")
    private MemVo memVo;

    @OneToOne
    @JoinColumn(name = "BID_ITEM_NAME")
    private BidItemVo bidItemVo;
}
