package feature.trace.vo;

import lombok.*;

import javax.persistence.Entity;

@Entity
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class traceVO {
        private String itemImg;
        private String itemName;
        private int itemNo;
        private int itemPrice;
    @Override
    public String toString() {
        return "traceVO{" +
                "itemNo=" + itemNo +
                ", itemImg='" + itemImg + '\'' +
                ", itemName='" + itemName + '\'' +
                ", itemPrice=" + itemPrice +
                '}';
    }
    }

