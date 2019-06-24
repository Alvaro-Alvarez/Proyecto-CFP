using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;

namespace Datos
{
    public class Conexion{ 

        public static MySqlConnection conn = new MySqlConnection("server=127.0.0.1; Uid=root; psw=; database=cfpnueva");
    }
}
