namespace Model.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("PhotoOfShoesView")]
    public partial class PhotoOfShoesView
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public long PhotoID { get; set; }

        [StringLength(200)]
        public string Image { get; set; }

        public bool? Status { get; set; }

        public long? ColorID { get; set; }
    }
}
