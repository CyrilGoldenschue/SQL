<?php

?>




<html lang="fr">
    <body>

        <table>
            <tr>
                <th>Name</th>
                <th>Firstname</th>
                <th>Assurance</th>
                <th>Reste</th>
                <th>Franchise</th>
                <th>Prime</th>
            </tr>
            <?php while($customer = $data->fetch()){ ?>
            <tr>
                <td><?= $customer[0] //Nom ?></td>
                <td><?= $customer[1] //Prénom ?></td>
                <td><?= $customer[5] //Assurance ?></td>
                <td><?= $customer[2] //Reste ?></td>
                <td><?= $customer[3] //Franchise ?></td>
                <td><?= $customer[7] //Prime ?></td>
            </tr>
            <?php } ?>
        </table>
    </body>
</html>
