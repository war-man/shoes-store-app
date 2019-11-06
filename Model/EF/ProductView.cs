namespace Model.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("ProductView")]
    public partial class ProductView
    {
        public long? ShoeID { get; set; }

        [StringLength(50)]
        public string Name { get; set; }

        [StringLength(200)]
        public string Descriptions { get; set; }

        [StringLength(200)]
        public string VideoIllustration { get; set; }

        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int CategoryID { get; set; }

        [StringLength(50)]
        public string CategoryName { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public long ColorID { get; set; }

        [StringLength(50)]
        public string ColorName { get; set; }

        public DateTime? DateCreateColor { get; set; }

        public bool? ColorStatus { get; set; }

        public int? ViewNumber { get; set; }

        public int? LikeNumber { get; set; }

        public DateTime? DateCreatePrice { get; set; }

        [Column(TypeName = "numeric")]
        public decimal? Price { get; set; }

        [Key]
        [Column(Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public long PhotoID { get; set; }

        [StringLength(200)]
        public string Image { get; set; }

        public bool? ImageStatus { get; set; }
    }
}